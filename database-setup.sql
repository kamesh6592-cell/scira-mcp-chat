-- Database Schema Setup for Scira MCP Chat
-- Run this script in your Neon SQL Editor to create all required tables

-- Create chats table
CREATE TABLE IF NOT EXISTS "chats" (
	"id" text PRIMARY KEY NOT NULL,
	"title" text DEFAULT 'New Chat' NOT NULL,
	"user_id" text NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL
);

-- Create messages table
CREATE TABLE IF NOT EXISTS "messages" (
	"id" text PRIMARY KEY NOT NULL,
	"chat_id" text NOT NULL,
	"role" text NOT NULL,
	"parts" json NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL
);

-- Add foreign key constraints
DO $$ 
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.table_constraints 
        WHERE constraint_name = 'messages_chat_id_chats_id_fk'
    ) THEN
        ALTER TABLE "messages" ADD CONSTRAINT "messages_chat_id_chats_id_fk" 
        FOREIGN KEY ("chat_id") REFERENCES "public"."chats"("id") ON DELETE cascade ON UPDATE no action;
    END IF;
END $$;

-- Create indexes for better performance
CREATE INDEX IF NOT EXISTS "idx_chats_user_id" ON "chats" ("user_id");
CREATE INDEX IF NOT EXISTS "idx_chats_updated_at" ON "chats" ("updated_at");
CREATE INDEX IF NOT EXISTS "idx_messages_chat_id" ON "messages" ("chat_id");
CREATE INDEX IF NOT EXISTS "idx_messages_created_at" ON "messages" ("created_at");

-- Verify tables were created
SELECT 
    table_name,
    column_name,
    data_type,
    is_nullable
FROM information_schema.columns 
WHERE table_schema = 'public' 
    AND table_name IN ('chats', 'messages')
ORDER BY table_name, ordinal_position;