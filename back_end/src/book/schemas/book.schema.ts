/* eslint-disable prettier/prettier */
import { Prop, Schema, SchemaFactory } from "@nestjs/mongoose";
import mongoose from "mongoose";
import { User } from "src/auth/schemas/auth.schema";

export enum Category{
    'adventure' = 'adventure',
    'comedy' = 'comedy',
    'drama' = 'drama',
    'fantasy' = 'fantasy',}


@Schema({timestamps: true})
export class Book{
    
    @Prop()
    title: string;

    @Prop()
    description: string;

    @Prop()
    author: string;

    @Prop()
    category :Category

    @Prop({type:mongoose.Schema.Types.ObjectId,ref:'User'})
    user:User
}
export const BookSchema = SchemaFactory.createForClass(Book);