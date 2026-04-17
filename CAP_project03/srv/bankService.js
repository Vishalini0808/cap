const cds = require ('@sap/cds');
const { SELECT, UPDATE, INSERT } = require('@sap/cds/lib/ql/cds-ql');

module.exports = cds.service.impl(function () {

   const { Customers , LoanTypes , LoanApplications , Branches, LoanApprovals, Loans} = this.entities;


   //validate customer age and mail id 
   this.before ('CREATE', Customers, async (req) => {

    const { dob, email, creditScore} = req.data;

    if(!dob) {
        return req.error(400,"DOB required");
    };

    const age = new Date ().getFullYear() - new Date(dob).getFullYear();
    if(age < 18 ) {
        req.error(400, "Customer must be atleast 18 years old");
    }

    if(!email.includes('@')) {
        req.error(400,"Invalid email format")
    }

    if(!creditScore) {
        req.data.creditScore = 650;
    };
   });

   
   // validate branch - regex for ifsc code
   this.before('CREATE',Branches, async (req) => {

    const { branchName, city, ifsc} = req.data;
    if (!ifsc || ! branchName || !city) {
        req.error(400, "Branch name/city/ifsc are mandatory");
    };

    const regex = /^[A-Z]{3}0{3}[0-9]{3}$/;
    if(!regex.test(ifsc)) {
        req.error(400,"IFSC code should match the required format");
    };
    
   })



   // validate credit score, req amount for loan
   this.before('CREATE',LoanApplications, async(req) => {

    const { requestedAmount, loanType_ID , customer_ID } = req.data;

    const customer = await SELECT.one.from(Customers).where({ ID : customer_ID });
    const loanType = await SELECT.one.from(LoanTypes).where({ ID : loanType_ID});

    if(!customer) req.error (400,"Customer not found");
    if(!loanType) req.error (400,"Loantype not found");

    if (requestedAmount > loanType.maxAmount) {
        req.error (400,"Request amount exceeds limit")
    };

    if ( customer.creditScore < 650) {
        req.error (400, "Credit score too low")
    };
   });



    // loanapproval action
    this.on('approveLoanApplication',async (req) => {

        const { remarks, loanApplicationId, employeeId } = req.data;

        await UPDATE(LoanApplications).set({ status : 'Approved'}).where({ ID : loanApplicationId});

        await INSERT.into(LoanApprovals).entries({ 
             approvaldate   : new Date(),
             approvalstatus : 'Approved',
             remarks ,
             loanApplication_ID: loanApplicationId,
             employee_ID       : employeeId
        });


        // action-action (triggering another action)
         const loans = await this.send('sanctionLoan',{ loanApplicationId });
        return `Loan approved and sanctioned ${loans}`
    });



    this.on('sanctionLoan', async (req) =>{

        const { loanApplicationId } = req.data;

        const application = await SELECT.one.from(LoanApplications).where({ ID : loanApplicationId });

        const loanType = await SELECT.one.from(LoanTypes).where({ ID : application.loanType_ID});

        const loan = await INSERT.into(Loans).entries({
            sanctionedAmount: application.requestedAmount,
            interestRate: loanType.interestRate,
            startDate: new Date(),
            endDate : new Date(new Date().setFullYear(new Date().getFullYear() + loanType.tenureYears)),
            loanStatus : 'Active',

            loanApplication_ID : loanApplicationId
        });

        return loan;
    });



    // generate EMI:
    this.on('generateEmi', async (req) => {

        // const { loanId } = req.data;


    })


   




});