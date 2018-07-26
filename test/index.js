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
})
