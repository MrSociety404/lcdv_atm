import { defineConfig } from "vite";
import vue from "@vitejs/plugin-vue";
import pugPlugin from "vite-plugin-pug";
import svgLoader from "vite-svg-loader";

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [vue(), pugPlugin(), svgLoader()],
  base: "",
});
