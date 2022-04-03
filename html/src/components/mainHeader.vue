<script lang="ts" setup>
import { ref } from "vue";
import Fleeca from "../assets/img/Fleeca.svg";
import Moon from "../assets/img/Moon.svg";
import Sun from "../assets/img/Sun.svg";

const isDarkMode = ref(true);

const toggleTheme = () => {
  isDarkMode.value = !isDarkMode.value;
  document.querySelector("html")?.classList.toggle("light");
};
</script>

<template lang="pug">
header.header
  Fleeca.header__logo
  Sun.header__button(v-if='isDarkMode' @click="toggleTheme")
  Moon.header__button(v-else @click="toggleTheme")
</template>

<style lang="scss">
.header {
  width: 100%;
  height: 20%;
  color: var(--textColor);
  padding: 1rem 2rem;
  display: flex;
  align-items: center;
  justify-content: space-between;
  &__logo {
    height: 3rem;
  }
  &__button {
    cursor: pointer;
    width: 2rem;
    height: auto;
  }
}
</style>
