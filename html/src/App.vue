<script setup lang="ts">
import mainHeader from "./components/mainHeader.vue";
import mainFooter from "./components/mainFooter.vue";

import { useStore } from "vuex";
import { onMounted, ref } from "vue";

const atmIsOpen = ref(false);
const store = useStore();

const setPlayerData = (data: any) => {
  const playerData = {
    accounts: {
      bank: 0,
      cash: 0,
    },
  };

  data.accounts.forEach((account: any) => {
    if (account.name === "bank") {
      playerData.accounts.bank = account.money;
    } else if (account.name === "money") {
      playerData.accounts.cash = account.money;
    }
  });
  store.commit("setPlayerData", playerData);
};

onMounted(() => {
  window.addEventListener("message", (event) => {
    const data = event.data;
    if (data !== undefined && data.type === "ui") {
      if (data.display === true) {
        atmIsOpen.value = true;
        setPlayerData(data.player);
      } else {
        atmIsOpen.value = false;
      }
    }
  });

  window.addEventListener("keyup", (event) => {
    if (event.key === "Escape") {
      fetch("https://lcdv_atm/escape", {
        method: "POST",
      });
    }
  });
});
</script>

<template lang="pug">
.atm(v-if="atmIsOpen")
  .atm__container
    mainHeader
    router-view
    mainFooter
</template>

<style lang="scss">
.atm {
  height: 100vh;
  width: 100vw;
  display: flex;
  align-items: center;
  justify-content: center;
  &__container {
    width: 62.5rem;
    height: calc(40.4375rem - 2px);
    position: relative;
    background-color: var(--backgroundColor);
    border-radius: 50px;
    padding: 1.9rem;
  }
  &__content {
    text-align: center;
    width: 100%;
    height: 70%;
    display: flex;
    align-items: center;
    justify-content: center;
    flex-direction: column;
    color: var(--textColor);
    position: relative;
  }
  &__title {
    font-size: 2.2em;
    margin-bottom: 0.5rem;
    font-weight: bold;
  }
  &__amount {
    font-size: 3em;
    font-family: Roboto;
    margin-block: 2.5rem;
  }
  &__message {
    color: var(--secondaryColor);
  }
  &__actions {
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 3rem;
  }
}

.atm__button {
  background-color: var(--primaryColor);
  color: white;
  border-radius: 5px;
  font-size: 1.5rem;
  cursor: pointer;
  transition: transform 0.2s ease-in-out;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 1rem;
  width: 15rem;
  height: 4rem;
  & svg {
    width: 1.2em;
  }
  &:active {
    transform: translateY(4px);
  }
  &-light {
    background-color: var(--lightColor);
    color: var(--textColor);
  }
  &-withicon {
    display: flex;
    align-items: flex-start;
    justify-content: center;
    gap: 1rem;
  }
}
</style>
