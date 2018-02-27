require 'test_helper'
require 'integration/api_test_helper'

class DataFileCUDTest < ActionDispatch::IntegrationTest
  include ApiTestHelper

  def setup
    admin_login
    @clz = 'data_file'
    @plural_clz = @clz.pluralize
    @project = @current_user.person.projects.first

    template_file = File.join(ApiTestHelper.template_dir, 'post_min_data_file.json.erb')
    template = ERB.new(File.read(template_file))
    @to_post = JSON.parse(template.result(binding))
  end

  def populate_extra_attributes
    extra_attributes = {}
    extra_attributes[:policy] = BaseSerializer::convert_policy Factory(:private_policy)
    extra_attributes.with_indifferent_access
  end

  def populate_extra_relationships
    person_id = @current_user.person.id
    project_id = @project.id
    extra_relationships = {}
    extra_relationships[:submitter] = JSON.parse "{\"data\" : [{\"id\" : \"#{person_id}\", \"type\" : \"people\"}]}"
    extra_relationships[:people] = JSON.parse "{\"data\" : [{\"id\" : \"#{person_id}\", \"type\" : \"people\"}]}"
    extra_relationships[:projects] = JSON.parse "{\"data\" : [{\"id\" : \"#{project_id}\", \"type\" : \"projects\"}]}"
    extra_relationships.with_indifferent_access
  end
end