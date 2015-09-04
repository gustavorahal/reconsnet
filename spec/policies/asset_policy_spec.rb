require 'rails_helper'

describe AssetPolicy do
  subject { AssetPolicy.new(user, asset) }


  context 'visitante não pode ver material do participante' do
    let(:user) { nil }
    let(:asset) { create(:asset_event_participant_material) }

    it { should_not permit(:show)       }
    it { should_not permit(:create)     }
    it { should_not permit(:new)        }
    it { should_not permit(:update)     }
    it { should_not permit(:edit)       }
    it { should_not permit(:destroy)    }
  end

  context 'visitante não pode ver material do professor' do
    let(:user) { nil }
    let(:asset) { create(:asset_event_teacher_material) }

    it { should_not permit(:show)       }
    it { should_not permit(:create)     }
    it { should_not permit(:new)        }
    it { should_not permit(:update)     }
    it { should_not permit(:edit)       }
    it { should_not permit(:destroy)    }
  end


  context 'usuário participante em evento pode ver material do participante' do
    let(:asset) { create(:asset_event_participant_material) }

    let(:user) {
      user = create(:user)
      user.add_role(:participant, asset.assetable)
      user
    }

    it { should     permit(:show)       }

    it { should_not permit(:create)     }
    it { should_not permit(:new)        }
    it { should_not permit(:update)     }
    it { should_not permit(:edit)       }
    it { should_not permit(:destroy)    }
  end

  context 'usuário participante em evento NÃO pode ver material do professor' do
    let(:asset) { create(:asset_event_teacher_material) }

    let(:user) {
      user = create(:user)
      user.add_role(:participant, asset.assetable)
      user
    }

    it { should_not permit(:show)       }
    it { should_not permit(:create)     }
    it { should_not permit(:new)        }
    it { should_not permit(:update)     }
    it { should_not permit(:edit)       }
    it { should_not permit(:destroy)    }
  end

  context 'usuário professor em evento pode administrar material do professor' do
    let(:asset) { create(:asset_event_teacher_material) }

    let(:user) {
      user = create(:user)
      user.add_role(:teacher, asset.assetable)
      user
    }

    it { should permit(:show)       }
    it { should permit(:create)     }
    it { should permit(:new)        }
    it { should permit(:update)     }
    it { should permit(:edit)       }
    it { should permit(:destroy)    }
  end

  context 'usuário professor GLOBAL só pode ver (não editar) material do professor' do
    let(:asset) { create(:asset_event_teacher_material) }

    let(:user) {
      user = create(:user)
      user.add_role(:teacher)
      user
    }

    it { should     permit(:show)       }

    it { should_not permit(:create)     }
    it { should_not permit(:new)        }
    it { should_not permit(:update)     }
    it { should_not permit(:edit)       }
    it { should_not permit(:destroy)    }
  end

  context 'usuário admin de evento pode administrar material do professor' do
    let(:asset) { create(:asset_event_teacher_material) }

    let(:user) {
      user = create(:user)
      user.add_role(:event_admin)
      user
    }

    it { should permit(:show)       }
    it { should permit(:create)     }
    it { should permit(:new)        }
    it { should permit(:update)     }
    it { should permit(:edit)       }
    it { should permit(:destroy)    }
  end



end