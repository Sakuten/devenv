const {expect} = require('chai')

describe('Login', function () {
  this.retries(4)

  beforeEach(function () {
    browser.reload()
  })

  it('Can successfully renders top page', function () {
    browser.url('http://frontend:8000/')
    browser.waitForVisible('p', 500)
    const title = $('p').getText()
    expect(title).to.include('Home')
  })

  it('Routes to login page', function () {
    browser.url('http://frontend:8000/')
    browser.waitForVisible('[data-test="home-login"]', 500)
    $('[data-test="home-login"]').click()
    expect(browser.getUrl()).to.equal('http://frontend:8000/lottery/login')
  })

  it('Can successfully authenticate with secret id in the get parameter', function () {
    browser.url('http://frontend:8000/lottery/login?sid=nCGX_hMrMZxRAak-W36kIzzxrup_SIKI')
    // Immediately shows reCAPTCHA
    browser.waitForVisible('iframe', 500)
    browser.frame($('iframe').value)
    $('.recaptcha-checkbox').click()
    browser.waitForVisible('.recaptcha-checkbox-checkmark', 5000)
    browser.frameParent()
    browser.waitForVisible('[data-test="applicationview"]', 2000)
    const title = $('[data-test="applicationview-title"]').getText()
    expect(title).to.equal('Logged in as nCGX_hMrMZxRAak-W36kIzzxrup_SIKI')
    const url = browser.getUrl()
    expect(url).to.equal('http://frontend:8000/lottery')
  })

  it('Can successfully authenticate', function () {
    browser.url('http://frontend:8000/lottery/login')
    // detecting QR Code here...
    browser.waitForVisible('iframe', 5000)
    browser.frame($('iframe').value)
    $('.recaptcha-checkbox').click()
    browser.waitForVisible('.recaptcha-checkbox-checkmark', 5000)
    browser.frameParent()
    browser.waitForVisible('[data-test="applicationview"]', 2000)
    const title = $('[data-test="applicationview-title"]').getText()
    expect(title).to.equal('Logged in as nCGX_hMrMZxRAak-W36kIzzxrup_SIKI')
    const url = browser.getUrl()
    expect(url).to.equal('http://frontend:8000/lottery')
  })

  afterEach(function () {
    if (!browser.isExisting('[data-test="applicationview"]')) {
      return
    }
    // Logout
    browser.execute("localStorage.setItem('Token', '');")
    browser.refresh()
    browser.waitForVisible('[data-test="applicationview"]', 500, true) // true for reverse
  })
})
