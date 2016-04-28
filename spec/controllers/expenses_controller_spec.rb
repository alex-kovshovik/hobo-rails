require 'rails_helper'

describe ExpensesController do
  before do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in user
  end

  let(:family) { create(:family) }
  let(:user) { create(:user, family: family) }
  let(:budget) { create(:budget, family: family, name: 'Grocery') }

  describe "GET #index" do
    context 'budget' do
      it 'renders all expenses for the budget' do
        create(:expense, budget: budget)

        kids = create(:budget, name: 'Kids')
        create(:expense, budget: kids)

        get 'index', { budget_id: budget.id }

        expect(response).to have_http_status(:ok)
        expect(assigns(:expenses).count).to eq(1) # Only for one budget
      end
    end

    context 'global' do
      it 'renders all expenses for the family' do
        create(:expense, budget: budget)

        kids = create(:budget, name: 'Kids')
        create(:expense, budget: kids)

        get 'index'

        expect(response).to have_http_status(:ok)
        expect(assigns(:expenses).count).to eq(2) # Across all budgets
      end
    end
  end
end
