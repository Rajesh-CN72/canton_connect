'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "693635b5258fe5f1cda720cf224f158c",
"assets/AssetManifest.bin.json": "69a99f98c8b1fb8111c5fb961769fcd8",
"assets/assets/fonts/NotoSansSC-Bold.ttf": "a06cc4724a503d6b785f48b1abf347a8",
"assets/assets/fonts/NotoSansSC-Medium.ttf": "f75f943b53c03fee72afaa786a3d924c",
"assets/assets/fonts/NotoSansSC-Regular.ttf": "9082cca410d52a9c2ab657a68b62d120",
"assets/assets/fonts/Poppins-Bold.ttf": "08c20a487911694291bd8c5de41315ad",
"assets/assets/fonts/Poppins-Medium.ttf": "bf59c687bc6d3a70204d3944082c5cc0",
"assets/assets/fonts/Poppins-Regular.ttf": "093ee89be9ede30383f39a899c485a82",
"assets/assets/images/addons/extra_rice.jpg": "3bab4a98cfcf8ed0c66e40a0aebefc18",
"assets/assets/images/addons/extra_sauce.jpg": "77b28af0b6488a766fd217823e4d0da0",
"assets/assets/images/addon_placeholder.png": "63de274eb419ed4b44de4ef0eb06bf40",
"assets/assets/images/background/app_background.jpg": "10ccf7b8a3c561b334293678adf29f75",
"assets/assets/images/background/background.jpg": "10ccf7b8a3c561b334293678adf29f75",
"assets/assets/images/background/back_ground_1.jpg": "10ccf7b8a3c561b334293678adf29f75",
"assets/assets/images/background/cta_background.jpg": "10ccf7b8a3c561b334293678adf29f75",
"assets/assets/images/background/home_background.jpg": "10ccf7b8a3c561b334293678adf29f75",
"assets/assets/images/default_avatar.png": "78e5de491aeabaa49100c4b7ffab8ca8",
"assets/assets/images/desserts/eggtart.jpg": "3714183bcbd0c25f722fab3fca497ca5",
"assets/assets/images/desserts/mango.jpg": "c2d8888891cff0c2101d65eaee7d1789",
"assets/assets/images/desserts/redbean.jpg": "ae22c5fc410301c3ca0f544c05fb99f3",
"assets/assets/images/drinks/coconut.png": "a8e59a638d1f5c13d00bed22a6bfa430",
"assets/assets/images/drinks/drink_placeholder.png": "0f8d4e923a723fc2a84934ce4cad4bc9",
"assets/assets/images/drinks/lemon_tea.png": "63de274eb419ed4b44de4ef0eb06bf40",
"assets/assets/images/family/combo_a.jpg": "801bbccb6c16554c2b168168b944736a",
"assets/assets/images/family/combo_b.jpg": "f022acbc0d467e08bd6e8256fa3374c7",
"assets/assets/images/favicon.png": "850355f56c8b589514b5a06fc68545d0",
"assets/assets/images/foods/appetizers/pork_dumplings.jpg": "66f6d3bae532feeafacfe1af094a3dc6",
"assets/assets/images/foods/appetizers/spring_rolls.jpg": "81e7f70fda748b1efd95c25e24e0b483",
"assets/assets/images/foods/desserts/mango_pudding.jpg": "878c12fbf7d55874d2763524819c7c97",
"assets/assets/images/foods/desserts/sesame_balls.jpg": "8a72c52ac7f432c911638c41f694b0bc",
"assets/assets/images/foods/drinks/bubble_tea.jpg": "5e54ef70edf2da07f81489922bc2c29b",
"assets/assets/images/foods/family_packages/family_feast.jpg": "8170ab48e1ba709b3110134d7e224a9a",
"assets/assets/images/foods/family_packages/seafood_banquet.jpg": "e7414dc94b5c155e707bd6169b1032ab",
"assets/assets/images/foods/main_course/beef_broccoli.jpg": "129372f5ce5d494ceaf287e570d0dadc",
"assets/assets/images/foods/main_course/kung_pao_chicken.jpg": "ca151f18c0a312b7cd881e3f7277e969",
"assets/assets/images/foods/main_course/sweet_sour_pork.jpg": "fd6e41f68ed6867dc3f66cfa2d1c4626",
"assets/assets/images/foods/rice_noodles/beef_chow_fun.jpg": "397ff515e5962c6a586a76992bb2e72e",
"assets/assets/images/foods/rice_noodles/yangzhou_rice.jpg": "aff6804656d9c0da0c00c4d5e7f87d3a",
"assets/assets/images/foods/seafood/kung_pao_shrimp.jpg": "366c304d37917029e7035b818757d0ac",
"assets/assets/images/foods/seafood/steamed_fish.jpg": "230d4cac78dd82b6cbc61dedb0aae7a7",
"assets/assets/images/foods/vegetarian/buddhas_delight.jpg": "68fa97f23ac653f0932a2a4297d40e1f",
"assets/assets/images/foods/vegetarian/mapo_tofu.jpg": "5b1799567b0918405cbaad6fa128b037",
"assets/assets/images/food_placeholder.png": "4d417d0e96c6eaf2f21d8cb1ebb7aa1b",
"assets/assets/images/food_placeholder_2.png": "4d417d0e96c6eaf2f21d8cb1ebb7aa1b",
"assets/assets/images/food_placeholder_3.png": "4d417d0e96c6eaf2f21d8cb1ebb7aa1b",
"assets/assets/images/healthy/fish.jpg": "66e48f30a17ee22964682c28c0f426e7",
"assets/assets/images/healthy/vegetables.jpg": "611437c135527b016b4cebeece1995d7",
"assets/assets/images/hero/hero_couple.png": "c27db193785a07d53051bdbe426c896d",
"assets/assets/images/hero/hero_dish.png": "ae0daab0e36d6d7f668556b9073bfa20",
"assets/assets/images/hero/hero_dish2.png": "7bbcef9cacb3c9ded6111358dffa35eb",
"assets/assets/images/hero/hero_dish_mobile.png": "94caa154abcc67b516a604a887142cd2",
"assets/assets/images/icons/icon-192.png": "58f6c6bd0edb194aaa02d17139b97799",
"assets/assets/images/icons/icon-512.png": "b36e7bc43edad44af6ad53621a77ae03",
"assets/assets/images/logo.png": "1ea29175423853ef91bb17fc0599eb37",
"assets/assets/images/logo_white.png": "1ea29175423853ef91bb17fc0599eb37",
"assets/assets/images/menu/bubble_tea.jpg": "34f49c70ae5ca24ce442a6af968f6da6",
"assets/assets/images/menu/family_feast.jpg": "801bbccb6c16554c2b168168b944736a",
"assets/assets/images/menu/fried_rice.jpg": "6d388cd90706c1909cda1a8eb9b90ffe",
"assets/assets/images/menu/hot_pot.jpg": "e1475c184a76d90550bbe7019ee329e1",
"assets/assets/images/menu/kung_pao_chicken.jpg": "9b3fa5453486dda67ff618507cdc46ee",
"assets/assets/images/menu/mango_pudding.jpg": "7a9269d8b5b5a1181750d2cbf6164259",
"assets/assets/images/menu/mapo_tofu.jpg": "c72301ef0dde755b9c51d69c01fde25e",
"assets/assets/images/menu/spring_rolls.jpg": "4f00c37a8ebf6a9fdc2bb287776e293c",
"assets/assets/images/menu/steamed_fish.jpg": "464d88335c0c9a429c655e5b824e269f",
"assets/assets/images/menu/sweet_sour_pork.jpg": "2496dffc817aef0397dceb19ea2ce2e5",
"assets/assets/images/menu/vegetable_stir_fry.jpg": "611437c135527b016b4cebeece1995d7",
"assets/assets/images/menu/weekend_special.jpg": "7d99851b04b36ea790b4c56b65f00bb7",
"assets/assets/images/pattern.png": "c78f2ed09a712982d50f32802dc82849",
"assets/assets/images/signature/duck.jpg": "67e3f5238551cf5979f01c66535dddea",
"assets/assets/images/signature/fish.jpg": "464d88335c0c9a429c655e5b824e269f",
"assets/assets/images/signature/pork.jpg": "d2a74e2e11d0e74a6445994311dcebc0",
"assets/assets/images/youth/chicken.jpg": "d85f1b5d9dd031c895bdc58277239904",
"assets/assets/images/youth/shrimp.jpg": "6ae03cab337f990d379e0eaf7dfaa05b",
"assets/assets/translations/en.json": "8a44e4a6a682a61cee9ab93b562614a0",
"assets/assets/translations/zh.json": "55beb289a6e7551369447c617901bf7a",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "deea0f5dba93813bade5621aec9b6b13",
"assets/NOTICES": "a4e09eace285c21a3c1607af84835d80",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/shaders/stretch_effect.frag": "40d68efbbf360632f614c731219e95f0",
"canvaskit/canvaskit.js": "8331fe38e66b3a898c4f37648aaf7ee2",
"canvaskit/canvaskit.js.symbols": "a3c9f77715b642d0437d9c275caba91e",
"canvaskit/canvaskit.wasm": "9b6a7830bf26959b200594729d73538e",
"canvaskit/chromium/canvaskit.js": "a80c765aaa8af8645c9fb1aae53f9abf",
"canvaskit/chromium/canvaskit.js.symbols": "e2d09f0e434bc118bf67dae526737d07",
"canvaskit/chromium/canvaskit.wasm": "a726e3f75a84fcdf495a15817c63a35d",
"canvaskit/skwasm.js": "8060d46e9a4901ca9991edd3a26be4f0",
"canvaskit/skwasm.js.symbols": "3a4aadf4e8141f284bd524976b1d6bdc",
"canvaskit/skwasm.wasm": "7e5f3afdd3b0747a1fd4517cea239898",
"canvaskit/skwasm_heavy.js": "740d43a6b8240ef9e23eed8c48840da4",
"canvaskit/skwasm_heavy.js.symbols": "0755b4fb399918388d71b59ad390b055",
"canvaskit/skwasm_heavy.wasm": "b0be7910760d205ea4e011458df6ee01",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "24bc71911b75b5f8135c949e27a2984e",
"flutter_bootstrap.js": "12506f2cec184ce9294573fa4fee527f",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "5cd2e9bd86cf341f4dbc800e54bf3838",
"/": "5cd2e9bd86cf341f4dbc800e54bf3838",
"main.dart.js": "641d9346e9ffc59f0ea9461fc172340d",
"manifest.json": "5cd68546060093ee68d140a8ad207b00",
"version.json": "d527be3574a2332e20829e300085ee4b"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
