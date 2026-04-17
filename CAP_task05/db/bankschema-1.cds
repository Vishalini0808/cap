// namespace bank.loan ;
 
// using { cuid, managed } from '@sap/cds/common';
 
 
 
// type Gender : String enum {Male; Female; Other};
 
// entity Customer : cuid, managed {
//     fullName       : String(100);
//     dob            : Date;
//     gender         : Gender;
//     phone          : String(15);
//     email          : String(100);
//     address        : String(250);
//     creditScore    : Integer;
 
//     accounts : composition of many Account on accounts.customer = $self;
   
//     loanApplications : Composition of many LoanApplication on loanApplications.customer = $self;
 
//     notifications : Composition of many CustomerNotification on notifications.customer = $self;
 
// }
 
 
// entity Branch : cuid, managed {
//     branchName : String(20);
//     city : String(20);
//     ifsc : String(20);
 
//     accounts : Association to  many Account on accounts.branch = $self ;
//     employees : Association to many Employee on employees.branch = $self;
 
// }
 
 
// entity Account : cuid, managed {
//     accountNumber : String(50);
//     accountType : String(20);
//     balance : Decimal(15,2);
 
//     customer : association to Customer;
//     branch : association to Branch;
   
// }
 
 
// entity LoanType :cuid, managed {
//     loanTypeName         : String;
//     maxAmount            : Decimal;
//     baseInterestRate     : Integer;
//     tenureYears          : Integer;
 
//     loanApplications : Association to many LoanApplication on loanApplications.loanType = $self ;
// }
 
 
// type LoanApplicationSts : String enum { Applied ; UnderReview ; Approved ; Active; Closed; Rejected };
 
// entity  LoanApplication : cuid, managed {
//     applicationDate     : Date;
//     requestedAmount     : Decimal;
//     status              : LoanApplicationSts default 'Applied';
 
//     customer            : Association to Customer;
//     account             : Association to Account;
//     loanType            : Association to LoanType;
 
//     document           : Composition of many LoanAppDocument on document.loanApplication = $self;
 
//     loanApproval        : Association to LoanApproval;
//     loan                : Association to Loan;

//     employee           : Association to many EmployeeLoanApp on employee.loanApplication = $self;
// }
 
 
// entity Document : cuid, managed {
//     documentType         : String;
//     uploadDate           : Date;
//     verificationStatus   : String;
 
//     // loanApplication        : Association to LoanApplication;
// }
 
 
// entity Employee : cuid, managed {
//     employeeName : String;
//     employeeRole : String;
 
//     branch : Association to Branch;
//     loanapprovals : Association to many LoanApproval on loanapprovals.employee = $self;

//     loanApplication : Association to many EmployeeLoanApp on loanApplication.employee = $self;
// }


 
// type ApprovalStatus: String enum {Approved ;Rejected };
 
// entity  LoanApproval : cuid, managed {
//     approvaldate   : Date;
//     approvalstatus : ApprovalStatus ;
//     remarks        : String;
 
//     loanApplication: Association to LoanApplication;
//     employee       : Association to Employee;
// }
 

// type LoanStatus: String enum { Active; Closed};
 
// entity Loan : cuid, managed {
//     sanctionedAmount:Decimal(15,2);
//     interestRate:Integer;
//     startDate:Date;
//     endDate : Date;
//     loanStatus :LoanStatus;
 
//     loanApplication : Association to LoanApplication;
 
//     emis : Composition of many EmiScedule on emis.loan = $self ;
//     guarantors : Composition of many LoanGuarantor on guarantors.loan = $self ;
//     disbursement : Composition of many Disbursement on disbursement.loan =$self;
// }
 
// entity Disbursement : cuid, managed {
//     disbursementAmount   : Decimal(15,2) ;
//     disbursementDate     : Date;
 
//     loan             : Association to Loan;
//     account            : Association to Account;
// }
 
 
// type EmiStatus : String enum { Pending ; Paid ; Overdue}
 
// entity EmiScedule : cuid, managed {
//     emiAmount       : Decimal(15,2);
//     dueDate         : Date;
//     emiStatus       : EmiStatus;
 
//     loan            : Association to Loan;
   
//     repayments      : Composition of many Repayment on repayments.emi = $self ;
//     penalties       : Composition of many Penalty on penalties.emi = $self ;
 
// }
 
 
// entity Repayment :cuid, managed {
//     paidAmount           : Decimal(15,2);
//     paymentDate          : Date;
//     paymentMode          : String;
 
//     emi : Association to EmiScedule;
//     account : Association to Account;
 
// }
 
// entity Penalty : cuid, managed {
//     penaltyAmount        : Decimal(15,2);
//     reason               : String;
//     appliedDate          : Date;
 
//     emi             : Association to EmiScedule;
// }

 
// entity Guarantor : cuid, managed {
//     guarantorName        : String(50);
//     phone                : String;
//     address              : String;

//     loans : Association to many LoanGuarantor on loans.guarantor =$self;
// }
 

// entity LoanGuarantor : cuid, managed {
 
//     loan              : Association to Loan;
//     guarantor         : Association to Guarantor;
// }

 
// entity Notification : cuid, managed {
//     message : String(500);
//     notificationDate : Date;
 
//     customers: Association to many CustomerNotification on customers.notification = $self;
// }


// entity CustomerNotification : cuid,managed {
//     customer : Association to Customer;
//     notification : Association to Notification;
// }

 
// entity LoanAppDocument : cuid, managed {
//     loanApplication : Association to LoanApplication;
//     document : Association to Document;
// }


// entity EmployeeLoanApp : cuid, managed {
//     loanApplication : Association to LoanApplication;
//     employee : Association to Employee;
// }