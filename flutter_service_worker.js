'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"manifest.json": "3beb92a7d1acc640e9ec0355cfa542fa",
"version.json": "9b818ca9511483c901bed1545384376c",
"canvaskit/skwasm_heavy.js.symbols": "0755b4fb399918388d71b59ad390b055",
"canvaskit/skwasm_heavy.js": "740d43a6b8240ef9e23eed8c48840da4",
"canvaskit/skwasm.js.symbols": "3a4aadf4e8141f284bd524976b1d6bdc",
"canvaskit/skwasm.js": "8060d46e9a4901ca9991edd3a26be4f0",
"canvaskit/canvaskit.js": "8331fe38e66b3a898c4f37648aaf7ee2",
"canvaskit/canvaskit.wasm": "9b6a7830bf26959b200594729d73538e",
"canvaskit/chromium/canvaskit.js": "a80c765aaa8af8645c9fb1aae53f9abf",
"canvaskit/chromium/canvaskit.wasm": "a726e3f75a84fcdf495a15817c63a35d",
"canvaskit/chromium/canvaskit.js.symbols": "e2d09f0e434bc118bf67dae526737d07",
"canvaskit/canvaskit.js.symbols": "a3c9f77715b642d0437d9c275caba91e",
"canvaskit/skwasm_heavy.wasm": "b0be7910760d205ea4e011458df6ee01",
"canvaskit/skwasm.wasm": "7e5f3afdd3b0747a1fd4517cea239898",
"index.html": "c8c66c8d4697863aa1cd10e9b5146dfb",
"/": "c8c66c8d4697863aa1cd10e9b5146dfb",
"flutter.js": "24bc71911b75b5f8135c949e27a2984e",
"assets/l10n/messages.en.json": "75e5cc8f8c8a75561df9021800c6ef91",
"assets/l10n/messages.ja.json": "e51fff7c2887b950cae15290de64ba8b",
"assets/AssetManifest.bin": "7facfd5cbf7532bcc467b9f653b0bb0a",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/packages/font_awesome_flutter/lib/fonts/Font-Awesome-7-Free-Solid-900.otf": "45564ea2afcb985775d0deaab034da97",
"assets/packages/font_awesome_flutter/lib/fonts/Font-Awesome-7-Brands-Regular-400.otf": "b2a0a53afb176b9eedbbf97b35a18ca8",
"assets/packages/font_awesome_flutter/lib/fonts/Font-Awesome-7-Free-Regular-400.otf": "c40213bbdc7575c121d537deb7196d21",
"assets/FontManifest.json": "c75f7af11fb9919e042ad2ee704db319",
"assets/NOTICES": "77e4a6967adbb57d3ae372035a466360",
"assets/assets/mock/about.en.json": "d385bf1c0bf8bbf23828dca15a292132",
"assets/assets/mock/content_showcase.ja.json": "7ee7b46152e7f44854c28fa246c4378c",
"assets/assets/mock/experience.en.json": "a258496b1024dbf50a0e75cd28dbb656",
"assets/assets/mock/content_showcase.en.json": "0f5dcdfc488025a8a807d63033933309",
"assets/assets/mock/software_skill.json": "bdab349dc22cc984be1fda43e23ca980",
"assets/assets/mock/core_skill.en.json": "0a12f32fb4d5c4fd1a07d7b9c4d759e4",
"assets/assets/mock/about.ja.json": "a8f282d6b45fd59bcc7be6ca89376577",
"assets/assets/mock/core_skill.ja.json": "a3dc2875874556be424056c8212bccd9",
"assets/assets/mock/experience.ja.json": "b5451f33325f80b1ec28ddf2bbf8fe93",
"assets/assets/apple-touch-icons.png": "181c431079338a07903cb31776e9b9d1",
"assets/assets/title.svg": "26afc8cd0e1263fbe5d60264e4b9d14c",
"assets/assets/navbar-logo.svg": "33db147c7029851857f3d1a1c8896c78",
"assets/assets/subtitle.svg": "c0478c6b56b11b8716dc4c05bdfbeaae",
"assets/assets/favicon.svg": "5ce5a7629b659ca65f17cacadad59984",
"assets/assets/header-bg.png": "f772849613a05bf0d3a60dd7a2084c9b",
"assets/assets/profile.svg": "57a2709f12047ce39568288a9bec993f",
"assets/shaders/stretch_effect.frag": "40d68efbbf360632f614c731219e95f0",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/fonts/MaterialIcons-Regular.otf": "0ab41311732380a2c7c0654fedcd6ad5",
"assets/AssetManifest.bin.json": "dd7e163a6227b31e20e3dc2587d0ea9f",
"main.dart.wasm": "2789b72985ff056afc218cc32e6ebaf2",
"flutter_bootstrap.js": "dbcbee42631f620e60aaa63b40487d9e",
"main.dart.mjs": "9a966e6041f065bbd73eb5dcb3cb1a70",
"favicon.ico": "dbe70351295e8e2b5237864a0840683e",
"main.dart.js": "37d48f68d10f1553b5340724ce199608"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"main.dart.wasm",
"main.dart.mjs",
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
