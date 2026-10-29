// Waterpunten en vereenvoudigde bergketens; GeoJSON gebruikt [lengtegraad, breedtegraad].
const waterItems = [
  { id: 'north-sea', name: 'Noordzee', lat: 56.4, lng: 3.2 },
  { id: 'channel', name: 'Het Kanaal', lat: 50.2, lng: -1.5 },
  { id: 'gibraltar', name: 'Straat van Gibraltar', lat: 35.96, lng: -5.6 },
  { id: 'mediterranean', name: 'Middellandse Zee', lat: 35, lng: 17 },
  { id: 'baltic', name: 'Oostzee', lat: 57, lng: 19.5 },
  { id: 'black-sea', name: 'Zwarte Zee', lat: 43, lng: 34.5 },
  { id: 'caspian', name: 'Kaspische Zee', lat: 42, lng: 50.7 },
];

const mountainItems = [
  { id: 'pyrenees', name: 'Pyreneeën' },
  { id: 'ardennes', name: 'Ardennen' },
  { id: 'alps', name: 'Alpen' },
  { id: 'caucasus', name: 'Kaukasus' },
  { id: 'urals', name: 'Oeral' },
];

const MOUNTAIN_FEATURES = {
  type: 'FeatureCollection',
  features: [
    {
      type: 'Feature',
      properties: { id: 'pyrenees' },
      geometry: {
        type: 'LineString',
        coordinates: [[-1.6, 43.2], [0, 42.7], [1.3, 42.6], [2.5, 42.4], [3.1, 42.4]],
      },
    },
    {
      type: 'Feature',
      properties: { id: 'ardennes' },
      geometry: {
        type: 'LineString',
        coordinates: [[4.1, 50.1], [5, 50.2], [5.8, 50], [6.2, 49.8]],
      },
    },
    {
      type: 'Feature',
      properties: { id: 'alps' },
      geometry: {
        type: 'LineString',
        coordinates: [[6.1, 44.1], [6.6, 45], [7, 45.9], [8.2, 46.4], [9.5, 46.8], [11, 47], [12.5, 47], [14.5, 47.5], [16, 47.7]],
      },
    },
    {
      type: 'Feature',
      properties: { id: 'caucasus' },
      geometry: {
        type: 'LineString',
        coordinates: [[37, 44.5], [39, 44], [41, 43.3], [43, 42.7], [45, 42], [47.5, 41.2], [49, 40.5]],
      },
    },
    {
      type: 'Feature',
      properties: { id: 'urals' },
      geometry: {
        type: 'LineString',
        coordinates: [[57.3, 51], [58.8, 53], [59.3, 55], [59, 57], [59.3, 59], [59.5, 61], [60, 63], [61, 65], [63, 67], [65.5, 68]],
      },
    },
  ],
};
