export const environment = {
  production: true,
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
