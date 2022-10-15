<script>
  import { Meteor } from 'meteor/meteor';

  // username/password text
  let username = "";
  let password = "";

  // authenticate a user: try to login on submit of form
  const handleSubmit = () => {
    Meteor.loginWithPassword(username, password);
  }
</script>

<!-- form to login -->
<form class="login-form" on:submit|preventDefault={handleSubmit}>
    <!-- username div with text -->
    <div>
        <label htmlFor="username">Username</label>

        <input
                type="text"
                placeholder="Username"
                name="username"
                required
                bind:value={username}
        />
    </div>

    <!-- password div with text -->
    <div>
        <label htmlFor="password">Password</label>

        <input
                type="password"
                placeholder="Password"
                name="password"
                required
                bind:value={password}
        />
    </div>
    <!-- submit button -->
    <div>
        <button type="submit">Log In</button>
    </div>
</form>
