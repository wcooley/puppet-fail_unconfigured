#! /usr/bin/env ruby -S rspec
require 'spec_helper'

describe 'the fail_unconfigured function' do
  let (:scope) { PuppetlabsSpec::PuppetInternals.scope }

  subject do
    scope.method :function_fail_unconfigured
  end

  before :each do
    scope.stubs(:lookupvar).with(anything).returns(:undefined)
  end

  it 'should exist' do
    Puppet::Parser::Functions.function('fail_unconfigured')\
      .should == 'function_fail_unconfigured'
  end

  it 'should raise a ParseError with error=not_configured' do
    lambda { subject.call([]) }\
      .should(raise_error(Puppet::ParseError, /\berror=not_configured\b/))
  end

  it 'should raise ParseError with default mocked facts' do
    scope.stubs(:lookupvar).with('node').returns('test_node')
    lambda { subject.call([]) }\
      .should(raise_error(Puppet::ParseError, /\bnode=test_node\b/))

    scope.stubs(:lookupvar).with('osfamily').returns('RedHat')
    lambda { subject.call([]) }\
      .should(raise_error(Puppet::ParseError, /\bosfamily=redhat\b/))
    scope.stubs(:lookupvar).with('operatingsystem').returns('CentOS')
    scope.stubs(:lookupvar).with('operatingsystemrelease').returns('5.8')

    lambda { subject.call([]) }\
      .should(raise_error(Puppet::ParseError) { |e|
        m = e.message
        m.should(match('\berror=not_configured\b'))
        m.should(match('\bosfamily=redhat\b'))
        m.should(match('\bnode=test_node\b'))
        m.should(match('\boperatingsystem=centos\b'))
        m.should(match('\boperatingsystemrelease=5.8\b'))
      })
  end

  it 'should raise ParseError with argument facts' do
    scope.stubs(:lookupvar).with('node').returns('test_node')
    scope.stubs(:lookupvar).with('lsbmajdistrelease').returns('5')
    scope.stubs(:lookupvar).with('osfamily').returns('RedHat')
    lambda { subject.call(['lsbmajdistrelease']) }\
      .should(raise_error(Puppet::ParseError) { |e|
        m = e.message
        m.should(match('\blsbmajdistrelease=5\b'))
        m.should(match('\bnode=test_node\b'))
        m.should(match('\berror=not_configured\b'))
        m.should_not(match('\bosfamily=redhat\b'))
      })
  end

#  it '...blah...' do
#    scope.function_fail_unconfigured([])
#  end
end
