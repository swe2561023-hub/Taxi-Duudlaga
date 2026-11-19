function calculateFare(distanceKm, waitingMin = 0) {
  const BASE = 3000;      // starting fee (₮)
  const PER_KM = 1500;    // per kilometre
  const PER_MIN = 200;    // per minute of waiting
  if (distanceKm < 0 || waitingMin < 0) {
    throw new Error('Invalid input');
  }
  return BASE + distanceKm * PER_KM + waitingMin * PER_MIN;
}

module.exports = { calculateFare };