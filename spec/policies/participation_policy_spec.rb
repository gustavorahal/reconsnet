require 'rails_helper'

describe ParticipationPolicy do
  subject { ParticipationPolicy.new(user, participation) }

  let(:participation) { create(:participation) }


  context 'para um visitante' do
    let(:user) { nil }

    it { should_not permit(:index)      }
    it { should_not permit(:show)       }
    it { should_not permit(:create)     }
    it { should_not permit(:new)        }
    it { should_not permit(:update)     }
    it { should_not permit(:edit)       }
    it { should_not permit(:destroy)    }
  end


  context 'para um voluntário SEM papel de gestor de eventos' do
    let(:user) { create(:user_volunteer_role) }

    it { should     permit(:index)      }
    it { should     permit(:show)       }

    it { should_not permit(:create)     }
    it { should_not permit(:new)        }
    it { should_not permit(:update)     }
    it { should_not permit(:edit)       }
    it { should_not permit(:destroy)    }
  end


  context 'para um voluntário COM papel de gestor de eventos' do
    let(:user) { create(:user_event_manager_role) }

    it { should permit(:index)      }
    it { should permit(:show)       }
    it { should permit(:create)     }
    it { should permit(:new)        }
    it { should permit(:update)     }
    it { should permit(:edit)       }
    it { should permit(:destroy)    }
  end


end