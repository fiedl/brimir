# Brimir is a helpdesk system to handle email support requests.
# Copyright (C) 2012-2015 Ivaldi https://ivaldi.nl/
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

require 'test_helper'

class Api::V1::EmailTemplatesControllerTest < ActionController::TestCase

  setup do
    @email_template = email_templates(:canned_reply)
  end

  test 'should show email template' do
    sign_in users(:alice)

    get :show, params: {
      auth_token: users(:bob).authentication_token,
      id: @email_template.id,
      format: :json
    }
    assert_response :success
  end

end
