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

  it('Can successfully authenicate with example1', function () {
    browser.url('http://frontend:8000/lottery/login')
    browser.waitForVisible('iframe', 3000)
    $('[data-test="loginview-username"]').setValue('example1')
    browser.frame($('iframe').value)
    $('.recaptcha-checkbox').click()
    browser.waitForVisible('.recaptcha-checkbox-checkmark', 5000)
    browser.frameParent()
    $('[data-test="loginview-login"]').click()
    setTimeout(() => {
      browser.refresh()
      browser.waitForVisible('h1', 3000)
      const title = $('h1').getText()
      expect(title).to.equal('Logged in as example1')
    }, 1000)
  })
})
