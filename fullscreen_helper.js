// fullscreen_helper.js
document.addEventListener('DOMContentLoaded', function() {
  function isStandalone() {
    return (window.navigator.standalone || window.matchMedia('(display-mode: standalone)').matches);
  }

  if (!isStandalone()) {
    const prompt = document.createElement('div');
    prompt.id = "fullscreen-prompt"; // Give it an ID for styling
    prompt.innerHTML = `
      <div id="prompt-content">  </div>
      <p>For a full-screen experience, add this app to your home screen:</p>
      <p>iOS: Tap the share icon and select "Add to Home Screen".</p>
      <p>Android: Tap the three dots menu and select "Add to Home screen".</p>
      <button id="close-prompt">Close</button>
    `;
    document.body.appendChild(prompt);

       // Close button functionality
       const closeButton = document.getElementById('close-prompt');
       closeButton.addEventListener('click', function() {
           prompt.style.display = 'none'; // Hide the prompt
       });


      // Add some basic styling (you'll likely want to improve this)
      const style = document.createElement('style');
      style.textContent = `
        #fullscreen-prompt {
          position: fixed; /* Or absolute, depending on your layout */
          top: 50%;
          left: 50%;
          transform: translate(-50%, -50%);
          background-color: rgba(0, 0, 0, 0.7); /* Semi-transparent background */
          color: white;
          padding: 20px;
          border-radius: 10px;
          z-index: 9999; /* Ensure it's on top */
          text-align: center;
        }
        #prompt-content{
            padding-bottom: 10px;
        }
      `;
      document.head.appendChild(style);

  }
});
