import { I18n } from "i18n-js";
window.I18n = I18n;

import translationsEn from "./locales/en.json";
import translationsEs from "./locales/es.json";

I18n.t = {
    ...translationsEn,
    ...translationsEs
};
