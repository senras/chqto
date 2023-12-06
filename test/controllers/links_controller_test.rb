class LinksControllerTest < ActionController::TestCase
    test 'show redirects to link name' do
        link = Link.create!(slug: 'test', name: 'http://example.com')
        get :show, slug: link.slug
        assert_redirected_to link.name
    end
    
    test 'show renders not_found when link is not found' do
        get :show, slug: 'not_found'
        assert_template :not_found
        assert_response :not_found
    end
end