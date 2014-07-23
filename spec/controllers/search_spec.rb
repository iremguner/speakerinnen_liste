require 'spec_helper'

describe SearchController do

  describe "search" do
    before do
      @indexed_users =  create_array_of_users(['1a','2b','3c','4d'])
      @co_indexed_users =  create_array_of_users(['xx','yy','zz','ßß'], {common_topic: 'common äöüß', prefix: 'co'})
      @unpublished_users = create_array_of_users(['1'], {published: false, prefix: 'unpub'})
    end

    context "when user is unublished" do
      0.upto(0) do |index|
        describe "user by firstname" do
          before do
            get :search, q: @unpublished_users[index].firstname
          end

          it "finds no matches" do
            ids = extract_ids_from_results(assigns(:results))
            expect(ids.length).to eq 0
          end
        end
      end
    end

    context "when user is indexed" do
      0.upto(3) do |index|
        describe "user by firstname" do
          before do
            get :search, q: @indexed_users[index].firstname
          end

          it "finds only exact matches" do
            ids = extract_ids_from_results(assigns(:results))
            expect(ids.length).to eq 1
            expect(ids).to include @indexed_users[index].id
          end
        end

        describe "user by lastname" do
          before do
            get :search, q: @indexed_users[index].lastname
          end
          it "finds only exact matches" do
            ids = extract_ids_from_results(assigns(:results))
            expect(ids.length).to eq 1
            expect(ids).to include @indexed_users[index].id
          end
        end

        describe "user by unique topics" do
          before do
            get :search, q: @indexed_users[index].topics[0].name
          end
          it "finds only exact matches" do
            ids = extract_ids_from_results(assigns(:results))
            expect(ids.length).to eq 1
            expect(ids).to include @indexed_users[index].id
          end
        end

        describe "user by common topics (also covers downcase before search)" do
          before do
            get :search, q: @co_indexed_users[index].topics[0].name.upcase
          end
          it "finds all exact matches" do
            ids = extract_ids_from_results(assigns(:results))
            expect(ids.length).to eq @co_indexed_users.length
            expect(ids).to include @co_indexed_users[index].id
          end
        end

      describe "user by unique bio element" do
        before do
          get :search, q: @indexed_users[index].firstname.gsub('first name','')+'-wanga'
        end
        it "finds only exact matches" do
          ids = extract_ids_from_results(assigns(:results))
          expect(ids.length).to eq 1
          expect(ids).to include @indexed_users[index].id
        end
      end
    # end of array
    end
  end

  # end of describe "search"
  end
end
