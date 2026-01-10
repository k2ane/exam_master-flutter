//
// if (loader) {
//   _flutter.loader.load({
//     onEntrypointLoaded: async function (engineInitializer) {
//       // loading.textContent = "Initializing engine...";
//       const appRunner = await engineInitializer.initializeEngine();
//       // loading.textContent = "Running app...";
//       await appRunner.runApp();
//       loader.classList.add("fade-out");
//       setTimeout(() => {
//         loader.remove();
//       }, 600);
//       loader.remove();
//     },
//   });
// }

_flutter.loader.load({
  onEntrypointLoaded: async function (engineInitializer) {
    const loader = document.querySelector("#loading-container");
    // loading.textContent = "Initializing engine...";
    const appRunner = await engineInitializer.initializeEngine();
    loader.classList.add("fade-out");
    // loading.textContent = "Running app...";
    await appRunner.runApp();
    setTimeout(() => {
      loader.remove();
    }, 600);
    loader.remove();
  },
});
