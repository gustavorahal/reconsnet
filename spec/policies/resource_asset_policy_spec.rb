require 'rails_helper'

describe ResourceAssetPolicy do
  subject { ResourceAssetPolicy.new(user, resource_asset) }


  context 'visitante não pode ver material do participante' do
    let(:user) { nil }
    let(:resource_asset) { create(:asset_event_participant_material) }

    it { should_not permit(:show)       }
    it { should_not permit(:create)     }
    it { should_not permit(:new)        }
    it { should_not permit(:update)     }
    it { should_not permit(:edit)       }
    it { should_not permit(:destroy)    }
  end

  context 'visitante não pode ver material do docente' do
    let(:user) { nil }
    let(:resource_asset) { create(:asset_event_instructor_material) }

    it { should_not permit(:show)       }
    it { should_not permit(:create)     }
    it { should_not permit(:new)        }
    it { should_not permit(:update)     }
    it { should_not permit(:edit)       }
    it { should_not permit(:destroy)    }
  end


  context 'usuário participante em evento pode ver material do participante' do
    let(:resource_asset) { create(:asset_event_participant_material) }

    let(:user) {
      user = create(:user)
      user.add_role(:participant, resource_asset.assetable)
      user
    }

    it { should     permit(:show)       }

    it { should_not permit(:create)     }
    it { should_not permit(:new)        }
    it { should_not permit(:update)     }
    it { should_not permit(:edit)       }
    it { should_not permit(:destroy)    }
  end

  context 'usuário participante em evento NÃO pode ver material do docente' do
    let(:resource_asset) { create(:asset_event_instructor_material) }

    let(:user) {
      user = create(:user)
      user.add_role(:participant, resource_asset.assetable)
      user
    }

    it { should_not permit(:show)       }
    it { should_not permit(:create)     }
    it { should_not permit(:new)        }
    it { should_not permit(:update)     }
    it { should_not permit(:edit)       }
    it { should_not permit(:destroy)    }
  end

  context 'usuário docente em evento pode administrar material do docente' do
    let(:resource_asset) { create(:asset_event_instructor_material) }

    let(:user) {
      user = create(:user)
      user.add_role(:instructor, resource_asset.assetable)
      user
    }

    it { should permit(:show)       }
    it { should permit(:create)     }
    it { should permit(:new)        }
    it { should permit(:update)     }
    it { should permit(:edit)       }
    it { should permit(:destroy)    }
  end

  context 'usuário docente GLOBAL só pode ver (não editar) material do docente' do
    let(:resource_asset) { create(:asset_event_instructor_material) }

    let(:user) {
      user = create(:user)
      user.add_role(:instructor)
      user
    }

    it { should     permit(:show)       }

    it { should_not permit(:create)     }
    it { should_not permit(:new)        }
    it { should_not permit(:update)     }
    it { should_not permit(:edit)       }
    it { should_not permit(:destroy)    }
  end

  context 'usuário admin de evento pode administrar material do docente' do
    let(:resource_asset) { create(:asset_event_instructor_material) }

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