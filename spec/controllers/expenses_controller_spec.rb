require 'rails_helper'

describe ExpensesController do
  before do
    allow(subject).to receive(:authenticate)
    allow(subject).to receive(:current_user).and_return(user)
  end

  let(:user) { create(:user) }
  let(:grocery) { user.budgets.where(name: 'Grocery').first }
  let(:gas) { user.budgets.where(name: 'Gas').first }
  let!(:expense) { create(:expense, budget: grocery) }

  describe 'GET #index' do
    let!(:expense2) { create(:expense, budget: gas) }

    context 'budget' do
      it 'renders all expenses for the budget' do
        get :index, params: { budget_id: grocery.id }

        expect(response).to have_http_status(:ok)
        expect(assigns(:expenses).count).to eq(1) # Only for one budget - Grocery
      end
    end

    context 'global' do
      it 'renders all expenses for the family' do
        get :index

        expect(response).to have_http_status(:ok)
        expect(assigns(:expenses).count).to eq(2) # Across all budgets
      end
    end
  end

  describe 'GET #show' do
    it 'renders expense' do
      get :show, params: { budget_id: grocery.id, id: expense.id }

      expect(response).to have_http_status(:ok)
      expect(assigns(:expense)).to eq(expense)
    end
  end

  describe 'POST #create' do
    it 'creates new expense' do
      post :create, params: { budget_id: grocery.id, expense: { amount: 32.23, comment: 'no comment' } }

      expect(response).to have_http_status(:ok)

      new_expense = assigns(:expense)
      expect(new_expense.amount).to eq(32.23)
      expect(new_expense.comment).to eq('no comment')
      expect(new_expense.created_by).to eq(user.id)
      expect(new_expense.updated_by).to eq(user.id)
      expect(new_expense.changed_by).to eq("ExpensesController/create")
    end

    it 'renders errors properly' do
      post :create, params: { budget_id: grocery.id, expense: { comment: 'no amount - error' } }

      expect(response).to have_http_status(:unprocessable_entity)

      expense_json = JSON.parse(response.body, symbolize_names: true)[:expense]
      expect(expense_json[:errors]).to eq("Amount can't be blank")
    end
  end
end
