require 'rails_helper'

RSpec.describe Admin::CategoriesController, type: :controller do


  describe 'GET #index' do
    it 'assigns @categories' do
      get :index
      expect(assigns(:categories)).to eq([create(:category)])
    end

    it 'renders the index view' do
      get :index
      expect(response).to render_template(:index)
    end
  end


  describe 'GET #show' do
    it 'does not assign the requested category to @category' do
      category = create(:category)
      get :index, id: category
      expect(assigns(:category)).to eq(nil)
    end

    it 'renders the #show view' do
      get :show, id: create(:category)
      expect(response).to render_template :show
    end
  end


  describe 'GET #new' do
    it 'assigns an empty name to the new category' do
      get :new
      expect(assigns(:category).name).to eq nil
    end

    it 'renders the new view' do
      get :new
      expect(response).to render_template(:new)
    end
  end


  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new category' do
        expect {
          post :create, category: attributes_for(:category)
        }.to change(Category, :count).by(1)
      end

      it 'redirects to the new category' do
        post :create, category: attributes_for(:category)
        expect(response).to redirect_to admin_category_path(Category.last)
      end
    end

    context 'with empty name' do
      it 'does not save the new category' do
        expect {
          post :create, category: attributes_for(:category_with_empty_name)
        }.to_not change(Category,:count)
      end

      it 're-renders the new view' do
        post :create, category: attributes_for(:category_with_empty_name)
        expect(response).to render_template :new
      end

      it 'displays an error message' do
        post :create, category: attributes_for(:category_with_empty_name)
        expect(assigns(:category).errors.messages).to eq({ name: ['can\'t be blank'] })
        expect(flash).to be_empty
      end
    end

    context 'with an existing name' do
      before :each do
        create(:category)
      end

      it 'does not save the new category' do
        expect {
          post :create, category: attributes_for(:category)
        }.to_not change(Category,:count)
      end

      it 're-renders the new view' do
        post :create, category: attributes_for(:category)
        expect(response).to render_template :new
      end

      it 'displays an error message' do
        post :create, category: attributes_for(:category)
        expect(assigns(:category).errors.messages).to eq({ name: ['has already been taken'] })
        expect(flash).to be_empty
      end
    end
  end


  describe 'PUT #update' do
    before :each do
      @category = create(:category)
    end

    context 'with valid attributes' do
      it 'assigns the requested category to @category' do
        put :update, id: @category, category: attributes_for(:alternate_category)
        expect(assigns(:category)).to eq(@category)
      end

      it 'change category\'s attributes' do
        alternate_category = attributes_for(:alternate_category)
        put :update, id: @category, category: alternate_category
        @category.reload
        expect(@category.name).to eq(alternate_category[:name])
      end

      it 'redirects to the updated category' do
        put :update, id: @category, category: attributes_for(:alternate_category)
        expect(response).to redirect_to(admin_category_path(@category))
      end
    end

    context 'with an empty name' do
      it 'assigns the requested category to @category' do
        put :update, id: @category, category: attributes_for(:category_with_empty_name)
        expect(assigns(:category)).to eq(@category)
      end

      it 'does not change category\'s attributes' do
        invalid_category = attributes_for(:category_with_empty_name)
        put :update, id: @category, category: invalid_category
        @category.reload
        expect(@category.name).not_to eq(invalid_category[:name])
      end

      it 're-renders the edit view' do
        put :update, id: @category, category: attributes_for(:category_with_empty_name)
        expect(response).to render_template(:edit)
      end

      it 'displays an error message' do
        put :update, id: @category, category: attributes_for(:category_with_empty_name)
        expect(assigns(:category).errors.messages).to eq({ name: ['can\'t be blank'] })
        expect(flash).to be_empty
      end
    end

    context 'with an existing name' do
      before :each do
        create(:alternate_category)
      end

      it 'assigns the requested category to @category' do
        put :update, id: @category, category: attributes_for(:alternate_category)
        expect(assigns(:category)).to eq(@category)
      end

      it 'does not change category\'s attributes' do
        invalid_category = attributes_for(:alternate_category)
        put :update, id: @category, category: invalid_category
        @category.reload
        expect(@category.name).not_to eq(invalid_category[:name])
      end

      it 're-renders the edit view' do
        put :update, id: @category, category: attributes_for(:alternate_category)
        expect(response).to render_template(:edit)
      end

      it 'displays an error message' do
        put :update, id: @category, category: attributes_for(:alternate_category)
        expect(assigns(:category).errors.messages).to eq({ name: ['has already been taken'] })
        expect(flash).to be_empty
      end
    end
  end


  describe 'DELETE destroy' do
    it 'deletes the category' do
      category = create(:category)
      expect {
        delete :destroy, id: category
      }.to change(Category, :count).by(-1)
    end

    it 'redirects to the index view' do
      delete :destroy, id: create(:category)
      expect(response).to redirect_to(admin_categories_path)
    end
  end
end
