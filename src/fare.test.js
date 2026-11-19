const test = require('node:test');
const assert = require('node:assert');
const { calculateFare } = require('./fare');

test('5 km without waiting', () => {
  assert.strictEqual(calculateFare(5), 10500);
});

test('3 km with 10 min waiting', () => {
  assert.strictEqual(calculateFare(3, 10), 9500);
});

test('negative distance throws an error', () => {
  assert.throws(() => calculateFare(-1));
});