// This file can be replaced during build by using the `fileReplacements` array.
// `ng build --prod` replaces `environment.ts` with `environment.prod.ts`.
// The list of file replacements can be found in `angular.json`.

export const environment = {
  production: false,
  basePathApiGateway:'http://localhost:8080/gateway/', 
  pathSearchTraffic:'/api/router/service/{instance}/ops/search?format=json&field=leg&value=0&protocol=http',
  pathServiceHeaderTraffic:'/api/router/service/{instance}/ops/http/{correlationId}/{INDEX}/getinfo?format=json&details=1&rheaders=1&sheaders=1',
  pathServiceContentReceive:'/api/router/service/{instance}/ops/stream/{correlationId}/{INDEX}/received',
  pathServiceContentSent:'/api/router/service/{instance}/ops/stream/{correlationId}/{INDEX}/sent',
  pathServiceTrace:'/api/router/service/{instance}/ops/trace/{correlationId}?format=json&sentData=0&receivedData=0',
  pathServiceCircuitpath:'/api/router/service/{instance}/ops/stream/{correlationId}/*/circuitpath',
  pathTopology:'/api/topology',
  basePathApiTraffic:'http://localhost:8080/traffic/'
};

/*
 * For easier debugging in development mode, you can import the following file
 * to ignore zone related error stack frames such as `zone.run`, `zoneDelegate.invokeTask`.
 *
 * This import should be commented out in production mode because it will have a negative impact
 * on performance if an error is thrown.
 */
// import 'zone.js/dist/zone-error';  // Included with Angular CLI.
