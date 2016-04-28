require 'rails_helper'

describe ExpensesController do
  before do
    @request.env['devise.mapping'] = Devise.mappings[:user]
    sign_in user
  end

  let(:family) { create(:family) }
  let(:user) { create(:user, family: family) }
  let(:budget) { create(:budget, family: family, name: 'Grocery') }
  let!(:expense) { create(:expense, budget: budget) }

  describe 'GET #index' do
    let(:budget_kids) { create(:budget, name: 'Kids') }
    let!(:expense2) { create(:expense, budget: budget_kids) }

    context 'budget' do
      it 'renders all expenses for the budget' do
        get 'index', budget_id: budget.id

        expect(response).to have_http_status(:ok)
        expect(assigns(:expenses).count).to eq(1) # Only for one budget
      end
    end

    context 'global' do
      it 'renders all expenses for the family' do
        get 'index'

        expect(response).to have_http_status(:ok)
        expect(assigns(:expenses).count).to eq(2) # Across all budgets
      end
    end
  end

  describe 'GET #show' do
    it 'renders expense' do
      get 'show', budget_id: budget.id, id: expense.id

      expect(response).to have_http_status(:ok)
      expect(assigns(:expense)).to eq(expense)
    end
  end

  describe 'POST #create' do
    it 'creates new expense' do
      post 'create', budget_id: budget.id, expense: { amount: 32.23, comment: 'no comment' }

      expect(response).to have_http_status(:ok)

      new_expense = assigns(:expense)
      expect(new_expense.amount).to eq(32.23)
      expect(new_expense.comment).to eq('no comment')
    end

    it 'renders errors properly' do
      post 'create', budget_id: budget.id, expense: { comment: 'no amount - error' }

      expect(response).to have_http_status(:unprocessable_entity)

      expense_json = JSON.parse(response.body, symbolize_names: true)[:expense]
      expect(expense_json[:errors]).to eq("Amount can't be blank")
    end
  end
end
