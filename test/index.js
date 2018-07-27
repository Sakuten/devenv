const {expect} = require('chai')

describe('Login', function () {
  this.retries(4)

  beforeEach(function () {
    browser.reload()
  })

  it('Can successfully renders top page', function () {
    browser.url('http://frontend:8000/')
    browser.waitForVisible('p', 3000)
    const title = $('p').getText()
    expect(title).to.include('Home')
  })

  it('Routes to login page', function () {
    browser.url('http://frontend:8000/')
    browser.waitForVisible('[data-test="home-login"]', 3000)
    $('[data-test="home-login"]').click()
    expect(browser.getUrl()).to.equal('http://frontend:8000/lottery/login')
  })

  it('Can successfully authenticate with secret id in the get parameter', function () {
    browser.url('http://frontend:8000/lottery/login?sid=6jt8DtRpI8jqxH2SVoNKNH_81Fuhmz4n')
    // Immediately shows reCAPTCHA
    browser.waitForVisible('iframe', 500)
    browser.frame($('iframe').value)
    $('.recaptcha-checkbox').click()
    browser.waitForVisible('.recaptcha-checkbox-checkmark', 5000)
    browser.frameParent()
    browser.waitForVisible('h1', 3000)
    const title = $('h1').getText()
    expect(title).to.include('Logged in as 6jt8DtRpI8jqxH2SVoNKNH_81Fuhmz4n')
  })

  it('Can successfully authenicate', function () {
    browser.url('http://frontend:8000/lottery/login')
    // detecting QR Code here...
    browser.waitForVisible('iframe', 5000)
    browser.frame($('iframe').value)
    $('.recaptcha-checkbox').click()
    browser.waitForVisible('.recaptcha-checkbox-checkmark', 5000)
    browser.frameParent()
    browser.waitForVisible('h1', 3000)
    const title = $('h1').getText()
    expect(title).to.include('Logged in as')
  })
})
