require 'helper'

describe Desk::Client do
  context "Article" do

    let(:endpoint) { "article" }
    let(:id) { 1 }
    let(:check_key) { "subject" }
    let(:check_value) { "Awesome Subject" }

    include_context "basic configuration"

    it_behaves_like "a list endpoint"

    it_behaves_like "a show endpoint"

    it_behaves_like "a create endpoint", {
      :subject => "Awesome Subject",
      :body => "Simply post here",
      :_links => {
        :topic => {
          :href => "/api/v2/topics/1",
          :class => "topic"
        }
      }
    }

    it_behaves_like "an update endpoint", {
      :subject => "How to make your customers happy",
      :body => "<strong>Use Desk.com</strong>",
      :body_email => "Custom email body for article",
      :body_email_auto => false,
      :_links => {
        :topic => {
          :href => "/api/v2/topics/1",
          :class => "topic"
        }
      }
    } do
      let(:check_value) { "How to make your customers happy" }
    end

    it_behaves_like "a delete endpoint"

    it_behaves_like "a search endpoint", {
      :text => "happy",
      :topic_ids => "1,2,4"
    }

    context "Translation" do

      let(:sub_endpoint) { "translation" }
      let(:sub_id) { "en" }
      let(:check_key) { "subject" }
      let(:check_value) { "Awesome Subject" }

      it_behaves_like "a sub list endpoint"

      it_behaves_like "a sub show endpoint"

      it_behaves_like "a sub create endpoint", {
        :locale => "es",
        :subject => "Spanish Translation",
        :body => "Traducción español aquí"
      } do
        let(:sub_id) { "es" }
        let(:check_value) { "Spanish Translation" }
      end

      it_behaves_like "a sub update endpoint", {
        :subject => "Updated Spanish Translation"
      } do
        let(:sub_id) { "es" }
        let(:check_value) { "Updated Spanish Translation" }
      end

    end
  end
end
