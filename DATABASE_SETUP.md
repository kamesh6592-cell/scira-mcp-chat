# Database Setup

This application uses PostgreSQL with Neon as the database provider.

## Quick Setup

1. **Create Neon Database**: Sign up at [neon.tech](https://neon.tech) and create a new project
2. **Run Database Setup**: Execute the SQL script in your Neon SQL Editor:
   ```bash
   # Copy and paste the contents of database-setup.sql into Neon SQL Editor
   ```
3. **Configure Environment Variables**: Add your database URL to Vercel or .env.local:
   ```
   DATABASE_URL=postgresql://username:password@host/database?sslmode=require
   ```

## Database Schema

The application requires these tables:

### `chats` table
- `id` (text, primary key)
- `title` (text, default: 'New Chat')
- `user_id` (text, required)
- `created_at` (timestamp)
- `updated_at` (timestamp)

### `messages` table
- `id` (text, primary key) 
- `chat_id` (text, foreign key to chats.id)
- `role` (text: 'user' or 'assistant')
- `parts` (json: message content parts)
- `created_at` (timestamp)

## Troubleshooting

If you get "relation 'chats' does not exist" error:
1. Ensure you've run the `database-setup.sql` script
2. Verify your `DATABASE_URL` is correct
3. Check that your Neon database is active (not paused)

## Environment Variables Required

```bash
DATABASE_URL=your_neon_database_url
# Optional for Vercel templates compatibility
POSTGRES_URL=your_neon_database_url
```