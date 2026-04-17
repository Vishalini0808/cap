using ShowRoom from './showroom-service';

annotate ShowRoom.Cars with  {
    
    price @mandatory;
    price @assert.range : [2000,3000000];
    
    colour @title : 'Car Colour';
}


annotate ShowRoom.Bookings with {

    totalAmount @title : 'Total Amount';
}

