require 'spec_helper'

describe SearchController do

  describe "search" do
    before do
      @indexed_users =  create_array_of_users(['1ä','2ö','3ü','4ß'])
      @unpublished_users = create_array_of_users(['1'], false,'unpub')
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

    # end of array
    end
  end

  # end of describe "search"
  end
end
