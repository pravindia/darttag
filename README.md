# FLutter Task


1.Write a simple application that accepts a value (integer) and returns the fibonacci value at that index of the value provided.
The application should be performant at scale to handle larger numbers without slowing down exponentially.


2. Write a customized function named: 'sortDoodles(order, list)' that accepts an array of values of different data types. The purpose of the function is to return
the list in a sorted format either ascending or descending. Supported data types are only numbers (integers and doubles), booleans and strings.
Note that the general custom of this function is such that all boolean values are less than all numbers which in turn are less than all strings as denoted thus:
  Boolean < Number < String.
The function should expect two parameters viz;
  - order: This tells the function whether to sort ascending or descending order. Possible values are 'ASC' or 'DESC'
  - list: A list of the items to be sorted.


3. Create a recursive function named: 'transformDoodles(list)' that accepts a multi-dimensional array of any data type and converts it to a uni-dimensional
array. For example,
  - transformDoodles([[1, 3], [true, "5"]]) should return [1, 3, true, "5"]
Note, write a clearly defined explainable code for this implementation without using the Array.prototype.flat() in-built function.