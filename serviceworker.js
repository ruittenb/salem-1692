
/**
 * Serviceworker for Salem 1692 Moderator
 */

const version = "0.48.11";
const cacheName = 'salem-1692-v' + version;
let filesToCache;

function getFilesToCache(debug) {
    const rootDir = debug ? '.' : '/salem-1692/dist';
    return [
        'index.html',
        'index.html?utm_source=pwa',
        'js/bundle.js',
        'css/normalize.min.css',
        'css/salem.min.css',
        'fonts/CaslonAntique.ttf',
        'fonts/CaslonAntique-Bold.ttf',
        'images/background-daytime.png',
        'images/background-night.png',
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
        'images/flag-de.png',
        'images/flag-es.png',
        'images/flag-fr.png',
        'images/flag-gb.png',
        'images/flag-it.png',
        'images/flag-nl.png',
        'images/flag-us.png',
        'images/gramophone.png',
        'images/icon-back.png',
        'images/icon-back-32.png',
        'images/icon-back-host-32.png',
        'images/icon-checked.png',
        'images/icon-cross.png',
        'images/icon-exit.png',
        'images/icon-forw.png',
        'images/icon-gear.png',
        'images/icon-lang.png',
        'images/icon-move.png',
        'images/icon-pawn.png',
        'images/icon-rot.png',
        'images/icon-unchecked.png',
        'images/overlay-broom.png',
        'images/overlay-gear.png',
        'images/overlay-hourglass.png',
        'images/overlay-lute.png',
        'images/overlay-night.png',
        'images/overlay-old-phone.png',
        'images/overlay-pawn.png',
        'images/overlay-scroll.png',
        'images/overlay-title.png',
        'images/overlay-village.png',
        'images/qr-icon-28.png',
        'images/qr-icon-40x28s.png',
        'images/tablelayout-1221.png',
        'images/tablelayout-1222.png',
        'images/tablelayout-2221.png',
        'images/tablelayout-2222.png',
    ].map(filename => `${rootDir}/${filename}`);
}

/**
 * Cache important files when installing
 */
self.addEventListener('install', function (event) {
    console.log('[ServiceWorker] Installing ', version);
    const debug = new URL(location).searchParams.get('debug');
    filesToCache = getFilesToCache(debug);
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
    console.log('[ServiceWorker] Activating ', version);
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

