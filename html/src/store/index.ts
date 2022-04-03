import { createStore } from "vuex";

export default createStore({
  state() {
    return {
      player: {
        accounts: {
          bank: 0,
          cash: 0,
        },
      },
    };
  },
  mutations: {
    setPlayerData(state: any, payload) {
      state.player = payload;
    },
  },
});
