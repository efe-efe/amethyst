import { allTokens } from "./localization";
import settings from "./settings";
import { writeFileSync, readdirSync } from "fs";
import { join } from "path";

const folders = ["./heroes", "./general"];

async function main() {
    await Promise.all(
        folders.map(folder => Promise.all(readdirSync(join(__dirname, folder)).map(path => import(join(__dirname, folder, path)))))
    );

    const currentLocalization = allTokens.map(([key, value]) => `\t\t"${key}" "${value}"\n`).join("");
    const completeLocalization = `"lang"\n{\n\t"Language" "english"\n\t"Tokens"\n\t{\n${currentLocalization}\n\t}\n}`;

    console.log(`Writing out ${allTokens.length} localization tokens`);

    writeFileSync(settings.localizationFile, completeLocalization);
}

main();
