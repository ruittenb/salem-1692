
/**
 * Serviceworker for Salem 1692 Moderator
 */

const version = 'v0.9.0';
const cacheName = 'salem-1692-' + version;
const rootDir = '/'; // '/salem-1692/dist'
const filesToCache = [
    'index.html',
    'index.html?utm_source=pwa',
    'js/bundle.js',
    'serviceworker.js',
    'css/normalize.min.css',
    'css/salem.css',
    'fonts/CaslonAntique.ttf',
    'fonts/CaslonAntique-Bold.ttf',
    'images/background-night.png',
    'images/background.png',
    'images/confirm-no.png',
    'images/confirm-yes.png',
    'images/favicon.ico',
    'images/favicon-16x16.png',
    'images/favicon-32x32.png',
    'images/favicon-57x57.png',
    'images/favicon-72x72.png',
    'images/favicon-96x96.png',
    'images/favicon-114x114.png',
    'images/favicon-144x144.png',
    'images/favicon-152x152.png',
    'images/favicon-180x180.png',
    'images/favicon-192x192.png',
    'images/favicon-300x300.png',
    'images/flag_de.png',
    'images/flag_es.png',
    'images/flag_fr.png',
    'images/flag_gb.png',
    'images/flag_it.png',
    'images/flag_nl.png',
    'images/flag_us.png',
    'images/gramophone.png',
    'images/icon_back.png',
    'images/icon_exit.png',
    'images/icon_forw.png',
    'images/icon_gear.png',
    'images/icon_lang.png',
    'images/icon_pawn.png',
    'images/overlay-gear.png',
    'images/overlay-night.png',
    'images/overlay-scroll.png',
    'images/overlay-title.png',
].map(filename => `${rootDir}/${filename}`);

/**
 * Cache important files when installing
 */
self.addEventListener('install', function (event) {
    console.log('[ServiceWorker] Installing');
    self.skipWaiting();
    event.waitUntil(
        caches.open(cacheName).then(function (cache) {
            console.log('[ServiceWorker] Caching app shell');
            return cache.addAll(filesToCache);
        })
    );
});

/**
 * Remove old caches when activating
 */
self.addEventListener('activate', function (event) {
    console.log('[ServiceWorker] Activating');
    event.waitUntil(
        caches.keys().then(function (keyList) {
            return Promise.all(keyList.map(function (key) {
                if (key !== cacheName) {
                    console.log('[ServiceWorker] Removing old cache', key);
                    return caches.delete(key);
                }
            }));
        })
    );
    return self.clients.claim();
});

/**
 * Stale-while-revalidate:
 * If found in cache, then send the version from cache.
 * Meanwhile, fetch the new version over the network and cache it.
 *
 * @see https://jakearchibald.com/2014/offline-cookbook/#stale-while-revalidate
 */
self.addEventListener('fetch', function (event) {
    if (event.request.method !== 'GET') {
        // We don't handle the request, but don't block it either
        return;
    }
    var requestFile = event.request.url.replace(/^https?:\/\/[^\/]+/, '').replace(/#.*/, '');
    if (filesToCache.indexOf(requestFile) !== -1) {
        // This file should be in the cache
        return cacheThenNetwork(event);
    }
    // In all other cases: just don't block the default
});

/**
 * All important framework files are served from the cache first,
 * while the cache is refreshed.
 */
function cacheThenNetwork(event) {
    event.respondWith(
        caches.open(cacheName).then(function (cache) {
            return cache.match(event.request).then(function (cacheResponse) {
                var fetchPromise = fetch(event.request).then(function (networkResponse) {
                    cache.put(event.request, networkResponse.clone());
                    return networkResponse;
                }).catch(function () {
                    //console.log('[ServiceWorker] could not fetch:', event.request.url);
                });
                return cacheResponse || fetchPromise;
            });
        })
    );
}

