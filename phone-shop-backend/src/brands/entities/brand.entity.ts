import { Entity, PrimaryGeneratedColumn, Column } from 'typeorm';

@Entity('brands')
export class Brand {
  @PrimaryGeneratedColumn()
  id: number;

  @Column({
    unique: true,
  })
  name: string;

  @Column({
    nullable: true,
  })
  logo: string;
}