## Make Food

This is a small application that can give results of a requested reciepe or a random based on input. It uses Gemini under the hood.

# Steps to run:

1. To try out the application, you need to generate a Gemini API key. See [https://ai.google.dev/gemini-api/docs/api-key](https://ai.google.dev/gemini-api/docs/api-key) on how to get the API Key.
2. Create a file name `api-keys.json` in the root directory.
3. Add the API Key in the file as shown below:
```json
{
    "GEMINI_API_KEY": "<YOUR-API-KEY>" # Replace <YOUR-API-KEY> with your API Key
}
```
4. Run the application using the following command:
```sh
flutter run --dart-define-from-file api-keys.json
```

# Screenshots

<img src="https://github.com/immadisairaj/make_food/assets/40348358/827de6d9-a70c-4f54-88bb-c855d4477b25" height="500">

<img src="https://github.com/immadisairaj/make_food/assets/40348358/2bce6120-fc31-45c0-9c56-0b16a99588a4" height="500">
