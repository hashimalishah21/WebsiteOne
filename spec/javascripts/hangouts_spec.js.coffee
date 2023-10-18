describe 'RefreshHangouts', ->
  beforeEach ->
    setFixtures sandbox({ id: 'hg-container' })
    @app = new window.HangoutsUtils()

  it 'calls refresh every 10 sec', ->
    spyOn window, 'setInterval'
    spyOn @app, 'ajaxRequest'

    @app.init()
    expect(window.setInterval).toHaveBeenCalledWith(@app.ajaxRequest, 10000)

  it 'replaces hg-management section if data has updated', ->
    spyOn @app, 'bindEvents'

    @app.container = 'old data'
    @app.updateHangoutsData 'new data'

    expect($('#hg-container').text()).toEqual('new data')
    expect(@app.bindEvents).toHaveBeenCalled()


  it 'does not replace hg-management section if data has not updated', ->
    spyOn @app, 'bindEvents'
    @app.updateHangoutsData 'new data'
    expect($('#hg-container').text()).toEqual('')

  it 'clears refresh repeat if href changes', ->
    spyOn window, 'clearInterval'
    @app.href = 'new_href'
    @app.ajaxRequest()
    expect(window.clearInterval).toHaveBeenCalledWith(@app.intervalId)
