RestClient = require '../lib/rest-client'
RestClientView = require '../lib/rest-client-view'

www = 'http://echo.jsontest.com/foo/bar'

describe "REST Client Package", ->

  beforeEach ->
    @clientView = new RestClientView
    @url = @clientView.find('.rest-client-url')[0]
    @url.value = www

    waitsForPromise ->
      atom.packages.activatePackage('rest-client')

    @clientView.initialize()

  for method in ['get', 'post']
    it "can send a #{method.toUpperCase()} request", ->
      expect(@url.value).toBe www
      @clientView.find(".rest-client-method-#{method}")[0].click()

      waitsFor ->
          @clientView.find('.rest-client-status')[0].textContent == '200 OK'
