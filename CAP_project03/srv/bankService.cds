using bank.loan as bl from '../db/bankSchema';

service bankService {

    entity Customers as projection on bl.Customer;
    entity Branches as projection on bl.Branch;
    entity Accounts as projection on bl.Account;
    entity LoanApplications as projection on bl.LoanApplication;
    entity LoanTypes as projection on bl.LoanType;
    entity Documents as projection on bl.Document;
    entity LoanApprovals as projection on bl.LoanApproval;
    entity Employees as projection on bl.Employee;
    entity Loans as projection on bl.Loan;
    entity Disbursements as projection on bl.Disbursement;
    entity EmiScedules as projection on bl.EmiScedule;
    entity Repayments as projection on bl.Repayment;
    entity Penalties as projection on bl.Penalty;
    entity Guarantors as projection on bl.Guarantor;
    entity LoanGuarantors as projection on bl.LoanGuarantor;

    action approveLoanApplication(loanApplicationId : UUID, employeeId : UUID, remarks: String) returns String;
    action sanctionLoan ( loanApplicationId : UUID) returns Loans;
    action generateEmi ( loanId : UUID) returns EmiScedules;

};