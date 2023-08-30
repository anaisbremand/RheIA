import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="ia-generator"
export default class extends Controller {
  static targets = ["form", "prompt", "description"]



  generate() {

    console.log("Envoi de requête à ChatGPT et Dall-E en cours...");

    const url = "https://api.openai.com/v1/chat/completions";
    const apiKey = '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';

    const demande = `Réalise les étapes suivante:
                    1. écris une description en maximum 300 caractères de post Instagram sur le thème : '${this.promptTarget.value}'.
                    La description doit être en FRANCAIS.
                    La description doit être entre crochet [].`

    const headers = {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${apiKey}`
      };
    const data = {
        model: "gpt-3.5-turbo",
        messages: [
            { role: 'user', content: demande }
        ]
      };

    fetch(url, {
      method: 'POST',
        headers: headers,
        body: JSON.stringify(data)
      })
      .then(response => response.json())
    .then(data => {

      const descriptionInstance = data.choices[0].message.content;
      console.log(descriptionInstance);

      fetch(`/posts`, { method: 'POST', headers: {'Content-Type': 'application/json'}, body: JSON.stringify( {description: descriptionInstance, from_chat_gpt: true})});

    })

    .catch(error => {
      console.error('Erreur lors de l\'appel à l\'API :', error);
    });



  }
}

//                 2. écris un prompt à donner à Dall-E pour générer des images à partir de la description que tu as inventée.
//                 Le prompt doit respecter ceci les conditions suivantes:
//                     a) Sans limite de caractère.
//                     b) Très haute qualité et détaillé.
//                     c) il doit être en anglais.
//                     d) contenir les mots "4K" et "Ultra realistic".
//                     e) Tout le prompt doit être entre accolades {}.;
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
