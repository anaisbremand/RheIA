import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="ia-generator"
export default class extends Controller {
  static targets = ["form", "prompt"]

  connect() {
  }

  generate() {
    const prompt = this.promptTarget.value;
    console.log(prompt);
    // console.log("Salut");
    // const url = "https://api.openai.com/v1/chat/completions";
    // const apiKey = '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';

    // const demande = this.promptTarget.value;



  }
}

// const url2 = "https://api.openai.com/v1/images/generations";


// button.addEventListener("click", () => {

//     button.classList.add("disabled");

//     const demande = `fais-moi une description en maximum 300 caractères de post Instagram sur le thème : '${question.value}', elle doit être en FRANCAIS. fais-moi un prompt (sans limite de caractère, de très haute qualité et détaillé) pour une IA générative d'images (Dall-E) à partir du thème mentionné ci-dessus. Ce prompt DOIT être en anglais et contenir les mots "4K" et "Ultra realistic". Tout le prompt doit être entre accolades.`;

//     const headers = {
//         'Content-Type': 'application/json',
//         'Authorization': `Bearer ${apiKey}`
//     };
//     const data = {
//         model: "gpt-3.5-turbo",
//         messages: [
//             { role: 'user', content: demande }
//         ]
//     };

//     fetch(url, {
//         method: 'POST',
//         headers: headers,
//         body: JSON.stringify(data)
//     })
//     .then(response => response.json())
//     .then(data => {
//         const reply = data.choices[0].message.content;
//         reponse.innerHTML = reply;
//     })
//     .catch(error => {
//         console.error('Erreur lors de l\'appel à l\'API :', error);
//     });




// });


// // curl https://api.openai.com/v1/images/generations \
// //   -H "Content-Type: application/json" \
// //   -H "Authorization: Bearer $OPENAI_API_KEY" \
// //   -d '{
// //     "prompt": "a white siamese cat",
// //     "n": 1,
// //     "size": "1024x1024"
// //   }'

// btnImage.addEventListener("click", () => {

//     const demande2 = "";
//     const headers2 = {
//         "Content-Type": "application/json",
//         "Authorization": `Bearer ${apiKey}`
//     }
//     const data2 = {
//         "prompt": demande2,
//         "n": 1,
//         "size": "512x512"
//       }

//     console.log("lancement de dallE");

//     fetch(url2, {
//         method: 'POST',
//         headers: headers2,
//         body: JSON.stringify(data2)
//     })

//     .then(response => response.json())
//     .then(data => {
//         console.log(data);
//         displayphoto.insertAdjacentHTML("afterbegin",`<img src="${data.data[0].url}" alt="" width="512px" height="512px">`)

//         // const reply2 = data.choices[0].message.content;
//         // reponse.innerHTML = reply;
//     });

// });
