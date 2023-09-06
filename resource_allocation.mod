
set J;  # Set of tasks
set C;  # Set of contractors

param P {C, J};  # Cost of contractor i for task j
param t {C, J};  # Processing time of contractor i for task j
var y {C, J} binary integer;  # Binary variable indicating assignment of task j to contractor i
var Ch {J} >=0 integer;  # Cumulative time of tasks
var B >=0 integer;

minimize TotalTime:
	Ch[10];

subject to AssignTask {j in J}:
        sum {i in C} y[i, j] = 1;  # Each task is assigned to exactly one contractor

subject to MaxTasksPerContractor {i in C}:
        sum {j in J} y[i, j] <= 10;  # Maximum k tasks can be assigned to each contractor

subject to BudgetConstraint:
    sum {i in C, j in J} y[i, j] * P[i, j] = B;  # Total cost should be within the budget

subject to BudgetValue: 
	B<=550; # Limiting Costs incurred by project

subject to TimeConstraint {j in 2..10}:
        Ch[j] = sum {i in C} y[i, j] * t[i, j] + Ch[j-1];  # Cumulative time for contractors

subject to First_Ch:
        Ch[1] = sum {i in C} y[i, 1] * t[i, 1]; 

subject to Last_Ch:
        Ch[10] >= sum {i in C, j in J} y[i, j] * t[i, j] ; 

subject to non_consecutive_tasks {i in C, j in 2..10}:
	 y[i, j] + y[i, j - 1] <= 1;





