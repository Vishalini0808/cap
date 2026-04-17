// Scenario 1 (Basic – Association)

// One Customer can have many Orders
// Each Order belongs to one Customer

// 🎯 Task:
// Define entities
// Use managed association
// Make it bidirectional

entity Customer {
    key ID : UUID;
    name : String;
    orders : Association to many Orders on orders.customer = $self;
}

entity Orders {
    key ID : UUID;
    itmes : String;
    customer : Association to one Customer;
}

// 🔥 Scenario 2 (Composition)

// One Order contains multiple OrderItems
// If Order is deleted → OrderItems should also be deleted
// 🎯 Task:
// Use composition
// Define parent → child correctly
// Add child → parent association

entity Order {
    key ID : UUID;
    orderItems : Composition of many OrderItems on orderItems.order = $self;
}

entity OrderItems {
    key ID : UUID;
    order : Association to Order;
}

// 🔥 Scenario 3 (Unmanaged Association)

// A Product belongs to a Category
// You want to manually control foreign key (category_ID)

// 🎯 Task:
// Define unmanaged association
// Use proper on condition
// Also define reverse association

entity Product { 
    key ID: UUID;
    category_ID : UUID;
    category : Association to Category on category.ID = $self.category_ID;
}

entity Category {
    key ID : UUID;
    products : Association to many Product on products.category_ID = $self.ID;
}

// 🔥 Scenario 4 (Mixed – Real World)

// A School has many Students (strong ownership)
// A Student can enroll in many Courses
// A Course can have many Students

// 🎯 Task:
// Use:
// Composition for School–Student
// Association (many-to-many) for Student–Course
// Hint: use junction entity

entity School {
    key ID : UUID;
    name : String;
    students : Composition of many Student on students.school = $self;
}

entity Student {
    key ID : UUID;
        name : String;
        school : Association to School;
        course : Association to many enrollment on course.student = $self;
}

entity Course {
    key ID : UUID;
        name : String;
        student : Association to many enrollment on student.course = $self;
}

entity enrollment {
    key ID : UUID;
    student : Association to Student;
    course : Association to Course;
}


// 🔥 Scenario 5 (Tricky – Think Carefully)

// A Manager manages many Employees
// Each Employee has exactly one Manager
// Manager is also an Employee

// 🎯 Task:
// Self-association
// Managed association
// Optional reverse navigation

entity Employee {
    key ID : UUID;
    name : String;
    role : String;
    salary : Decimal(15,2);
    manager : Association to Employee;
}