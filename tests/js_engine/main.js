// Example JavaScript file for minification testing

// Function to add two numbers
function addNumbers(a, b) {
  return a + b;
}

// Function to subtract two numbers
function subtractNumbers(a, b) {
  return a - b;
}

// Using a template string and a variable
const name = "GitHub Actions";
console.log(`Testing minification with ${name}!`);

// An array of numbers
const numbers = [1, 2, 3, 4, 5];

// Using map to create a new array
const doubledNumbers = numbers.map((number) => number * 2);
console.log(doubledNumbers);

// Object with methods
const calculator = {
  add: (x, y) => x + y,
  subtract: (x, y) => x - y,
  multiply: (x, y) => x * y,
  divide: (x, y) => x / y,
};

// Using the calculator object
console.log(calculator.add(5, 7));
console.log(calculator.subtract(10, 5));

// Testing async function
async function fetchData(url) {
  try {
    const response = await fetch(url);
    const data = await response.json();
    console.log(data);
  } catch (error) {
    console.error("Error fetching data:", error);
  }
}

// Invoking async function (this will fail without a valid URL or in a non-browser environment)
fetchData("https://api.github.com/repos/nizarmah/auto-minify");

// End of file
