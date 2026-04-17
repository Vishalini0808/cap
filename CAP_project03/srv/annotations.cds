using { bankService } from './bankService';

annotate bankService.LoanTypes with {

    maxAmount @assert.range:[1,9999999999];
    loanTypeName @assert.unique
};

annotate bankService.Branches with {

    ifsc @assert.unique
};


annotate bankService.Accounts with {

    accountNumber @assert.unique
};
