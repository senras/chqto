class LinkTest < ActiveSupport::TestCase
    test 'slug is required' do
        link = Link.new
        assert_not link.valid?
        assert_includes link.errors[:slug], "can't be blank"
    end

    test 'slug is unique' do
        link = Link.create!(slug: 'test')
        link = Link.new(slug: 'test')
        assert_not link.valid?
        assert_includes link.errors[:slug], 'has already been taken'
    end

    test 'name is required' do
        link = Link.new
        assert_not link.valid?
        assert_includes link.errors[:name], "can't be blank"
    end

    test 'name is unique' do
        link = Link.create!(slug: 'test', name: '