# todo_riverpod

Implement Todo Riverpod Using

1. Synchronous TODO App
   ✅ Optimization - Using ProviderScope to restrict the items to rebuild again and again.
   ✅ Debounce - Limiting the call time of search query.
   ✅ App Theme - Toggling between light and dark theme.
2. Asynchronous TODO App

   1️⃣  enum based app
      ✅ Computed States as a function not a seprate provider.
      ✅ Each and every possibility of showing error and data to user. (IMP)
      ✅ Transparent loading indicators
     -loader_overlay: for transparent background while loading.
     -flutter_spinkit: for loading indicators.

   2️⃣ sealed class based app
   3️⃣ AsyncValue based app
   4️⃣ AsyncValue + Hive (data persistance) based app
