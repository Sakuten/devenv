const {expect} = require('chai')

describe('Login', function () {
  this.retries(4)

  beforeEach(function () {
    browser.reload()
  })

  it('Can successfully authenicate with example1', function () {
    browser.url('http://frontend:8000/')
    $('input[name="username"]').setValue('example1')
    $('input[name="password"]').setValue('example1')
    $('button').click()
    browser.waitForVisible('h1', 3000)
    const title = $('h1').getText()
    expect(title).to.equal('Logged in as example1')
  })
})
